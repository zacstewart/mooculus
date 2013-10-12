require 'spec_helper'

describe Competency do
  describe '::update' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:exercise) { FactoryGirl.create(:exercise) }

    describe 'with one ace score' do
      before do
        FactoryGirl.create(:score,
                           attempt_number:  1,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)
      end

      it 'creates a competency with the correct estimates' do
        described_class.update(user, exercise)
        result = described_class.where(user_id: user, exercise_id: exercise).first
        expect(result.estimate).to eq(0.5040725929008488)
        expect(result.min_estimate).to eq(0.5040725929008488)
        expect(result.max_estimate).to eq(0.5040725929008488)
      end
    end

    describe 'with one ace score and one correct score' do
      before do
        FactoryGirl.create(:score,
                           attempt_number:  1,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)

        FactoryGirl.create(:score,
                           attempt_number:  2,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)
      end

      it 'creates a competency with the correct estimates' do
        described_class.update(user, exercise)
        result = described_class.where(user_id: user, exercise_id: exercise).first
        expect(result.estimate).to eq(0.36331041253932506)
        expect(result.min_estimate).to eq(0.36331041253932506)
        expect(result.max_estimate).to eq(0.36331041253932506)
      end
    end

    describe 'when the user has an existing competency for the exercise and an ace score' do
      before do
        FactoryGirl.create(:competency,
                           user:          user,
                           exercise:      exercise,
                           min_estimate:  0.36331041253932506,
                           max_estimate:  0.36331041253932506,
                           estimate:      0.36331041253932506)

        FactoryGirl.create(:score,
                           attempt_number:  1,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)

        FactoryGirl.create(:score,
                           attempt_number:  2,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)
        FactoryGirl.create(:score,
                           attempt_number:  1,
                           count_hints:     0,
                           complete:        true,
                           exercise:        exercise,
                           user:            user)
      end

      it 'updates the competency with the correct estimates and uncertainty' do
        described_class.update(user, exercise)
        result = described_class.where(user_id: user, exercise_id: exercise).first
        expect(result.uncertainty).to eq(0.18241542972259484)
        expect(result.estimate).to eq(0.5457258422619199)
        expect(result.min_estimate).to eq(0.36331041253932506)
        expect(result.max_estimate).to eq(0.5457258422619199)
      end
    end
  end
end
