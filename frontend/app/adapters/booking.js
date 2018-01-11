import ApplicationAdapter from './application';

export default ApplicationAdapter.extend({
  search(options) {
    const url = this.buildURL('booking') + '/search';
    return this.ajax(url, 'GET', { data: options });
  }
});
