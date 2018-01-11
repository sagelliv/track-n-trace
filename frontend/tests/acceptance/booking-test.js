import { test } from 'qunit';
import moduleForAcceptance from 'frontend/tests/helpers/module-for-acceptance';

moduleForAcceptance('Acceptance | booking');

test('visiting /booking', function(assert) {
  visit('/bookings');

  andThen(function() {
    assert.equal(currentURL(), '/bookings');
  });

  const blNumber = 'TXG790195200';
  fillIn('.data-test-booking-search input', blNumber);
  click('.data-test-booking-search button');

  andThen(() => {
    assert.equal(currentURL(), `/bookings/${blNumber}`);
    assert.equal(find('.data-test-booking-origin').text(), 'Xingang');
  });
});
