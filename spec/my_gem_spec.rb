# frozen_string_literal: true

RSpec.describe MyGem, type: :module do
  it { expect(described_class::VERSION).not_to be_nil }
end
