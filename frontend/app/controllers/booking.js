import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';

export default Controller.extend({
  flashMessages: service(),

  toggleWatch: task(function *() {
    const model = this.get('model');
    model.set('watch', !model.get('watch'));

    yield model.save().then(() =>{
      this.get('flashMessages').success('Successfully updated booking');
    });
  })
});
