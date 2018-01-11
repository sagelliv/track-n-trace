import Controller from '@ember/controller';

export default Controller.extend({
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
      });
    }
  }
});
