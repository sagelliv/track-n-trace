import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  flashMessages: service(),

  actions: {
    toggleWatch() {
      const model = this.get('model');
      model.set('watch', !model.get('watch'));
      model.save().then(() =>{
        this.get('flashMessages').success('Successfully updated booking');
      });
    }
  }
});
