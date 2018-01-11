import DS from 'ember-data';
const { attr, belongsTo, Model } = DS;

export default Model.extend({
  booking:       belongsTo('booking'),

  size:          attr('string'),
  number:        attr('string'),
  containerType: attr('string')
});

