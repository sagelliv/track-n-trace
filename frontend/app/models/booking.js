import DS from 'ember-data';
const { attr, hasMany, Model } = DS;

export default Model.extend({
  containers:    hasMany('container'),

  blNumber:      attr('string'),
  steamshipLine: attr('string'),
  watch:         attr('boolean'),
  origin:        attr('string'),
  destination:   attr('string'),
  vessel:        attr('string'),
  voyage:        attr('string'),
  vesselEta:     attr('date')
});
