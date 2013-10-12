require 'spec_helper'

describe Score do
  describe '#summary' do
    context "when attempted_content is 'hint'" do
      subject { Score.new(attempt_content: 'hint') }

      it 'is :hint' do
        expect(subject.summary).to eq(:hint)
      end
    end

    context 'when attempt_number is 1 and it is complete and count_hints is 0' do
      subject { Score.new(attempt_number: 1, complete: true, count_hints: 0) }

      it 'is :ace' do
        expect(subject.summary).to eq(:ace)
      end
    end

    context 'when complete is true' do
      subject { Score.new(complete: true) }

      it 'is :correct' do
        expect(subject.summary).to eq(:correct)
      end
    end

    context 'when complete is false' do
      subject { Score.new(complete: false) }

      it 'is :incorrect' do
        expect(subject.summary).to eq(:incorrect)
      end
    end
  end
end
