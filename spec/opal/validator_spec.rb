require "spec_helper"

describe React::Validator do
  describe "validate" do
    describe "Presence validation" do
      it "should check if required props provided" do
        validator = React::Validator.build do
          requires :foo
          requires :bar
        end

        expect(validator.validate({})).to eq(["Required prop `foo` was not specified", "Required prop `bar` was not specified"])
        expect(validator.validate({foo: 1, bar: 3})).to eq([])
      end

      it "should check if passed non specified prop" do
        validator = React::Validator.build do
          optional :foo
        end

        expect(validator.validate({bar: 10})).to eq(["Provided prop `bar` not specified in spec"])
        expect(validator.validate({foo: 10})).to eq([])
      end
    end

    describe "Type validation" do
      it "should check if passed value with wrong type" do
        validator = React::Validator.build do
          requires :foo, type: String
        end

        expect(validator.validate({foo: 10})).to eq(["Provided prop `foo` was not the specified type `String`"])
        expect(validator.validate({foo: "10"})).to eq([])
      end

      it "should check if passed value with wrong custom type" do
        stub_const 'Bar', Class.new
        validator = React::Validator.build do
          requires :foo, type: Bar
        end

        expect(validator.validate({foo: 10})).to eq(["Provided prop `foo` was not the specified type `Bar`"])
        expect(validator.validate({foo: Bar.new})).to eq([])
      end

      it "should support Array[Class] validation" do
        validator = React::Validator.build do
          requires :foo, type: Array[Hash]
        end

        expect(validator.validate({foo: [1,'2',3]})).to eq(["Provided prop `foo` was not an Array of the specified type `Hash`"])
        expect(validator.validate({foo: [{},{},{}]})).to eq([])
      end
    end

    describe "Limited values" do
      it "should check if passed value is not one of the specified values" do
        validator = React::Validator.build do
          requires :foo, values: [4,5,6]
        end

        expect(validator.validate({foo: 3})).to eq(["Value `3` for prop `foo` is not an allowed value"])
        expect(validator.validate({foo: 4})).to eq([])
      end
    end
  end

  describe "default_props" do
    it "should return specified default values" do
      validator = React::Validator.build do
        requires :foo, default: 10
        requires :bar
        optional :lorem, default: 20
      end

      expect(validator.default_props).to eq({foo: 10, lorem: 20})
    end
  end
end
