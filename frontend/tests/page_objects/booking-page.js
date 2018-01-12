export default class BookingPage {
  constructor(assert, number) {
    this.assert = assert;
    this.number = number;
  }

  visit(url) {
    visit(url);
    return this;
  }

  searchBooking() {
    fillIn('.data-test-booking-search input', this.number);
    click('.data-test-booking-search .btn');
    return this;
  }

  assertPath(path) {
    andThen(() => {
      this.assert.equal(currentURL(), path);
    });
    return this;
  }

  assertOnDetailsPage() {
    this.assertPath(`/bookings/${this.number}`);
    return this;
  }

  assertSearchCompleted() {
    andThen(() => {
      this.assert.equal(this.findText('.data-test-booking-origin'), 'Origin: Xingang');
      this.assert.equal(this.findText('.data-test-bl-number'), this.number);
    });
    return this;
  }

  findText(selector) {
    return find(selector).text().trim()
  }
}
