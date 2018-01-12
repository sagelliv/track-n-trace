import DS from 'ember-data';
const { attr, belongsTo, Model } = DS;

export default Model.extend({
  booking:      belongsTo('booking'),

  createdAt:    attr('date'),
  eventChanges: attr('string')
});
