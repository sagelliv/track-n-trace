import Component from '@ember/component';
import { computed } from '@ember/object';

export default Component.extend({
  text: computed('buttonTask.isRunning', function() {
    const text = this.get('buttonText');
    return this.get('buttonTask.isRunning') ? text + 'ing...' : text;
  })
});
