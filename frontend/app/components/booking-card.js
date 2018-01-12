import Component from '@ember/component';
import { computed } from '@ember/object';

export default Component.extend({
  eventSorting: ['createdAt:desc'],
  orderedEvents: computed.sort('events', 'eventSorting'),

  buttonIcon: computed('booking.watch', function() {
    const defaultClass = 'glyphicon ';
    const stateClass = this.get('booking.watch') ?
      'glyphicon-eye-close' : 'glyphicon-eye-open';
    return defaultClass + stateClass;
  })
});
