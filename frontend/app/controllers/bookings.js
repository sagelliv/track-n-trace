import Controller from '@ember/controller';

export default Controller.extend({
  searchTerm: null,

  actions: {
    search() {
      const adapter = this.get('store').adapterFor('booking');
      adapter.search({
        bl_number: this.get('searchTerm'),
        steamship_line: 'pil'
      });
    }
  }
});
