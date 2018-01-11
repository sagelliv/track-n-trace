import Controller from '@ember/controller';

export default Controller.extend({
  searchTerm: null,

  actions: {
    search() {
      this.get('store').findRecord('booking', this.get('searchTerm'));
    }
  }
});
