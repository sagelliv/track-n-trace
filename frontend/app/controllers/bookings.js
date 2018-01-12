import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  flashMessages: service(),
  searchTerm: null,

  actions: {
    search() {
      const adapter = this.get('store').adapterFor('booking');
      adapter.search({
        bl_number: this.get('searchTerm'),
        steamship_line: 'pil'
      }).then((booking) => {
        this.get('store').pushPayload('booking', booking);
        const slug = booking['data']['attributes']['blNumber'];
        this.transitionToRoute('booking', slug);
      }).catch((response) => {
        const error = response.errors[0].detail;
        this.get('flashMessages').danger(error);
      });
    }
  }
});
