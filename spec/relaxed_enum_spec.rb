RSpec.describe RelaxedEnum do
  class ActiveRecordDummy
    def status
      self.class.statuses.invert[@status]
    end

    def status=(arg)
      raise ArgumentError unless self.class.statuses.values.include?(arg)

      @status = arg
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    def self.statuses
      { foo: 0, bar: 1 }.with_indifferent_access
    end
  end

  class EnumDummy < ActiveRecordDummy
    include RelaxedEnum

    relax_enum :status
  end

  subject { EnumDummy.new }

  describe ".relax_enum" do
    it "it allows setting an enum via an integer" do
      subject.status = 1
      expect(subject.status).to eq("bar")
    end

    it "it allows setting an enum via a string" do
      subject.status = "1"
      expect(subject.status).to eq("bar")
    end

    it "it allows setting an enum via a string representing a key" do
      subject.status = "bar"
      expect(subject.status).to eq("bar")
    end

    it "it sets an error when the input is invalid" do
      subject.status = "baz"
      expect(subject.errors[:status]).to eq(["is not valid"])
    end
  end
end
