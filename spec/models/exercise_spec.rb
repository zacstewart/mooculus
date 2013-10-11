require 'spec_helper'

describe Exercise do
  let!(:first_exercise) { FactoryGirl.create(:exercise, position: 1) }
  let!(:last_exercise) { FactoryGirl.create(:exercise, position: 3) }
  subject { FactoryGirl.build(:exercise, position: 2, page: 'some-exercise.html') }

  let!(:problems) { [
    FactoryGirl.create(:problem, exercise: subject, weight: 2),
    FactoryGirl.create(:problem, exercise: subject, weight: 3)
  ] }

  describe '#name' do
    it 'gets the name from the page' do
      expect(subject.name).to eq('some-exercise')
    end
  end

  describe '#total_weight' do
    it "is the sum of it's problems' weights" do
      expect(subject.total_weight).to eq(5)
    end
  end

  describe '#problem_from_bag' do
    it 'returns a random problem that belongs to the exercise' do
      expect(subject.problem_from_bag).to be_in(problems)
    end
  end

  describe '#next_exercise' do
    it 'returns the next exercise by position' do
      expect(subject.next_exercise).to eq(last_exercise)
    end
  end

  describe '#previous_exercise' do
    it 'returns the previous exercise by position' do
      expect(subject.previous_exercise).to eq(first_exercise)
    end
  end


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
