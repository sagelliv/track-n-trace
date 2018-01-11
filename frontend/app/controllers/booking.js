import Controller from '@ember/controller';
import { computed } from '@ember/object';

export default Controller.extend({
  containers: computed('model.containers.[]', function() {
    return this.get('model.containers');
  })
});
