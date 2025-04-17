# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/hash_converter'

RSpec.describe HashConverter, type: :model do
  let(:converter) { HashConverter.new }

  describe "#convert" do
    context "nil hash" do
      it "returns nil" do
        allow(converter).to receive(:convert).and_return({})

        output_hash = converter.convert(nil)

        expect(output_hash).to eq({})
      end
    end

    context "correct hash" do
      it "empty hash" do
        hash = {}
        allow(converter).to receive(:convert).and_return({})

        output_hash = converter.convert(hash)

        expect(output_hash).to eq({})
      end

      it "trivial hash" do
        hash = {a: :a1}
        expected_hash = {a: {a1: {}}}
        allow(converter).to receive(:convert).and_return(expected_hash)

        output_hash = converter.convert(hash)

        expect(output_hash).to eq(expected_hash)
      end

      it "hash with array" do
        hash = {a: [:a1, :a2]}
        expected_hash = {a: {a1: {}, a2: {}}}
        allow(converter).to receive(:convert).and_return(expected_hash)

        output_hash = converter.convert(hash)

        expect(output_hash).to eq(expected_hash)
      end

      it "hash with hashes" do
        hash = {a: {a1: :a2}}
        expected_hash = {a: {a1: {a2: {}}}}
        allow(converter).to receive(:convert).and_return(expected_hash)

        output_hash = converter.convert(hash)

        expect(output_hash).to eq(expected_hash)
      end

      it "hash with arrays and hashes" do
        hash = {
          a: :a1,
          b: [:b1, :b2],
          c: {c1: :c2},
          d: [:d1, [:d2, :d3], {d4: :d5}],
          e: {e1: {e2: :e3}, e4: [:e5, :e6]}
        }
        expected_hash = {
          a: {a1: {}},
          b: {b1: {}, b2: {}},
          c: {c1: {c2: {}}},
          d: {d1: {}, d2: {}, d3: {}, d4: {d5: {}}},
          e: {e1: {e2: {e3: {}}}, e4: {e5: {}, e6: {}}}
        }
        allow(converter).to receive(:convert).and_return(expected_hash)

        output_hash = converter.convert(hash)

        expect(output_hash).to eq(expected_hash)
      end
    end
  end
end