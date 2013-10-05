require 'spec_helper'

describe Exercise do
  let!(:first_exercise) { FactoryGirl.create(:exercise, position: 1) }
  let!(:last_exercise) { FactoryGirl.create(:exercise, position: 3) }
  subject { FactoryGirl.build(:exercise, position: 2, page: 'some-exercise.html') }

  let!(:problems) { [
    FactoryGirl.create(:problem, exercise: subject, weight: 2),
    FactoryGirl.create(:problem, exercise: subject, weight: 3)
  ] }

  its(:name) { should eq('some-exercise') }
  its(:total_weight) { should eq(5) }
  its(:problem_from_bag) { should be_in(problems) }
  its(:next_exercise) { should eq(last_exercise) }
  its(:previous_exercise) { should eq(first_exercise) }

  describe '::first_by_position' do
    it 'retrieves the first exercise by position' do
      expect(described_class.first_by_position).to eq(first_exercise)
    end
  end

  describe '::last_by_position' do
    it 'retrieves the last exercise by position' do
      expect(described_class.last_by_position).to eq(last_exercise)
    end
  end
end
