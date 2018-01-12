import Route from '@ember/routing/route';

export default Route.extend({
  model(params) {
    return this.get('store').query('booking', {
      filter: { bl_number: params.booking_slug }
    }).then((bookings) => bookings.get('firstObject'));
  }
});

