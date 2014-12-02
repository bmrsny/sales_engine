require_relative 'test_helper'
require_relative '../lib/phone_book'
require_relative '../data/fixtures/'  # ~> LoadError: cannot load such file -- /Users/cluhring/Desktop/Chris'_Code/event_reporter/event_attendees.csv

class IntegrationTest < Minitest::Test

  def test_lookup_by_id
    phone_book = PhoneBook.new
    entries = phone_book.lookup_by_id('3760')
    assert_equal 1, entries.length
    entry = entries.first
    assert_equal "Mike", entry.first_name
    assert_equal "Maloney", entry.last_name
    assert_equal "Mike Maloney", entry.name
    assert_equal "4349071000", entry.phone_number #"434-907-1000"
    assert_equal "3760", entry.id
    assert_equal "1/31/09 19:08", entry.reg_date
    assert_equal "ahillemsen1@jumpstartlab.com", entry.email_address
    assert_equal "459 7th Ave. Apt1", entry.street
    assert_equal "Brooklyn", entry.city
    assert_equal "NY", entry.state
    assert_equal "11215", entry.zipcode
  end

  # def test_lookup_by_reg_date
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_reg_date('11/12/08 17:18')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end

  # def test_lookup_by_first_name
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_first_name('Audrey')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end

  def test_lookup_by_last_name
    phone_book = PhoneBook.new
    entries = phone_book.lookup_by_last_name('Friedman').sort_by {|e| e.first_name}

    assert_equal 3, entries.length
    e1, e2, e3 = entries

    assert_equal "Andrea Friedman", e1.name
    assert_equal "3745", e1.id
    assert_equal "1/31/2009 21:25", e1.reg_date
    assert_equal "muywalksb@jumpstartlab.com", e1.email_address
    assert_equal "313-269-0000", e1.home_phone
    assert_equal "1234 Fake Street", e1.street
    assert_equal "East Lansing", e1.city
    assert_equal "MI", e1.state
    assert_equal "48823", e1.zipcode

    assert_equal "Kevin Friedman", e2.name
    assert_equal "fvnsroek@jumpstartlab.com", e2.email_address
    assert_equal "203-808-5000", e2.home_phone
    assert_equal "1051 Danby Rd", e2.street
    assert_equal "Ithaca", e2.city
    assert_equal "NY", e2.state
    assert_equal "14850", e2.zip_code
    assert_equal "1/20/2009 21:25", e2.reg_date
    assert_equal "1071", e2.id

    assert_equal "Julie Friedman", e3.name
    assert_equal "4231", e3.id
    assert_equal "2/1/2009", e3.reg_date
    assert_equal "yqttwendellwyatt@jumpstartlab.com", e3.email_address
    assert_equal "787-613-9000", e3.home_phone
    assert_equal "Urb. Floral Park Gautier Benitez St. #53", e3.street
    assert_equal "San Juan", e3.city
    assert_equal "PR", e3.state
    assert_equal "00917", e3.zipcode
  end

  def test_lookup_by_home_phone
    phone_book = PhoneBook.new
    entries = phone_book.lookup_by_home_phone('530-919-3000')
    assert_equal 1, entries.length
    entry = entries.first
    assert_equal "Audrey", entry.first_name
    assert_equal "Hasegan", entry.last_name
    assert_equal "Audrey Hasegan", entry.name
    assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
    assert_equal "8", entry.id
    assert_equal "11/12/08 17:18", entry.reg_date
    assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
    assert_equal "1570 Old Ranch Rd.", entry.street
    assert_equal "Placerville", entry.city
    assert_equal "CA", entry.state
    assert_equal "95667", entry.zipcode
    # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  end

  # def test_lookup_by_street
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_street('1570 Old Ranch Rd.')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end

  # def test_lookup_by_city
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_city('Placerville')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end

  # def test_lookup_by_state
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_state('CA')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end

  # def test_lookup_by_first_zipcode
  #   phone_book = PhoneBook.new
  #   entries = phone_book.lookup_by_zipcode('95667')
  #   assert_equal 1, entries.length
  #   entry = entries.first
  #   assert_equal "Audrey", entry.first_name
  #   assert_equal "Hasegan", entry.last_name
  #   assert_equal "Audrey Hasegan", entry.name
  #   assert_equal "530-919-3000", entry.phone_number #"434-907-1000"
  #   assert_equal "8", entry.id
  #   assert_equal "11/12/08 17:18", entry.reg_date
  #   assert_equal "ffbbieucf@jumpstartlab.com", entry.email_address
  #   assert_equal "1570 Old Ranch Rd.", entry.street
  #   assert_equal "Placerville", entry.city
  #   assert_equal "CA", entry.state
  #   assert_equal "95667", entry.zipcode
  #   # 8,11/12/08 17:18,Audrey,Hasegan,ffbbieucf@jumpstartlab.com,530-919-3000,1570 Old Ranch Rd.,Placerville,CA,95667
  # end
end
