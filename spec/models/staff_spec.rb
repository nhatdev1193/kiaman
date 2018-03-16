describe Staff do
  before(:each) { @staff = Staff.new(email: 'staff@example.com') }

  subject { @staff }

  it { should respond_to(:email) }

  it '#email returns a string' do
    expect(@staff.email).to match 'staff@example.com'
  end

  it { is_expected.to have_and_belong_to_many(:roles) }
  it { is_expected.to have_many(:permissions) }
end
