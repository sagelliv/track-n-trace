import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';

export default Controller.extend({
  flashMessages: service(),
  searchTerm: null,

  search: task(function *() {
    const adapter = this.get('store').adapterFor('booking');
    yield adapter.search({
      bl_number: this.get('searchTerm'),
      steamship_line: 'pil'
    }).then(this._successfulSearch.bind(this))
      .catch(this._catchError.bind(this))
      .finally(() => this.set('searchTerm', null))
  }).drop(),

  _successfulSearch(booking) {
    this.get('store').pushPayload('booking', booking);
    const slug = booking['data']['attributes']['blNumber'];
    this.transitionToRoute('booking', slug);
  },

  _catchError(response) {
    const error = response.errors[0].detail;
    this.get('flashMessages').danger(error);
  }
});
