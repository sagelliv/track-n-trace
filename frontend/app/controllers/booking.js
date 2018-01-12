import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';
import { computed } from '@ember/object';

export default Controller.extend({
  flashMessages: service(),

  buttonIcon: computed('model.watch', function() {
    const defaultClass = 'glyphicon ';
    const stateClass = this.get('model.watch') ?
      'glyphicon-eye-close' : 'glyphicon-eye-open';
    return defaultClass + stateClass;
  }),

  toggleWatch: task(function *() {
    const model = this.get('model');
    model.set('watch', !model.get('watch'));

    yield model.save().then(() =>{
      this.get('flashMessages').success('Successfully updated booking');
    });
  })
});
