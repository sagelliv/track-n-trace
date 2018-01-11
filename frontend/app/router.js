import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('bookings');
  this.route('booking', { path: '/bookings/:booking_slug' });
});

export default Router;
