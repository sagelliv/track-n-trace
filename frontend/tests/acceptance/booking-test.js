import { test } from 'qunit';
import moduleForAcceptance from 'frontend/tests/helpers/module-for-acceptance';
import BookingPage from '../page_objects/booking-page';

moduleForAcceptance('Acceptance | booking');

test('search for a booking', function(assert) {
  new BookingPage(assert, 'TXG790195200')
    .visit('/bookings')
    .assertPath('/bookings')
    .searchBooking()
    .assertOnDetailsPage()
    .assertSearchCompleted()
});
