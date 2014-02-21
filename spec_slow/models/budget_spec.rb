require_relative '../spec_helper'

describe Budget do
  it "defaults the end date" do
    jane = FactoryGirl.create(:user, email: 'jane@doe.com')
    john = FactoryGirl.create(:user, email: 'john@doe.com')

    janes_first = FactoryGirl.create(:budget, user: jane, starts_on: Timeliness.parse('08/05/2013'))
    janes_third = FactoryGirl.create(:budget, user: jane, starts_on: Timeliness.parse('10/05/2013'))
    janes_second = FactoryGirl.create(:budget, user: jane, starts_on: Timeliness.parse('09/05/2013'))

    johns_first = FactoryGirl.create(:budget, user: john, starts_on: Timeliness.parse('02/01/2014'))
    johns_second = FactoryGirl.create(:budget, user: john, starts_on: Timeliness.parse('02/15/2014'))

    janes_first.default_end_date!
    janes_second.default_end_date!
    janes_third.default_end_date!
    johns_first.default_end_date!
    johns_second.default_end_date!

    janes_first.reload.ends_on.should == Timeliness.parse('09/04/2013').to_date
    janes_second.reload.ends_on.should == Timeliness.parse('10/04/2013').to_date
    janes_third.reload.ends_on.should == (Timeliness.parse('10/05/2013') + 1.month - 1.day).to_date

    johns_first.reload.ends_on.should == Timeliness.parse('02/14/2014').to_date
    johns_second.reload.ends_on.should == (Timeliness.parse('02/15/2014') + 1.month - 1.day).to_date
  end
end
