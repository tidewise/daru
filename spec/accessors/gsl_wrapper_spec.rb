if Daru.has_gsl?
  describe Daru::Accessors::GSLWrapper do
    before :each do
      @stub_context = Object.new
      @gsl_wrapper = Daru::Accessors::GSLWrapper.new([1,2,3,4,5,6], @stub_context)
    end

    context ".new" do
      it "actually creates a GSL Vector" do
        expect(@gsl_wrapper.data).to eq(GSL::Vector.alloc(5,6))
      end

      it "dups a GSL::Vector when given one" do
        gsl_vector = GSL::Vector.alloc()
        expect(gsl_vector).to receive(:dup) { GSL::Vector.alloc(5,6) }
        @gsl_wrapper = Daru::Accessors::GSLWrapper.new(gsl_vector, @stub_context)
        expect(@gsl_wrapper.data).to eq(GSL::Vector.alloc(5,6))
      end

      it "dups a GSL::Int when given one" do
        gsl_vector = GSL::Int.alloc()
        expect(gsl_vector).to receive(:dup) { GSL::Int.alloc(5,6) }
        @gsl_wrapper = Daru::Accessors::GSLWrapper.new(gsl_vector, @stub_context)
        expect(@gsl_wrapper.data).to eq(GSL::Int.alloc(5,6))
      end

      it "dups a GSL::Complex when given one" do
        gsl_vector = GSL::Complex.alloc()
        expect(gsl_vector).to receive(:dup) { GSL::Complex.alloc(5,6) }
        @gsl_wrapper = Daru::Accessors::GSLWrapper.new(gsl_vector, @stub_context)
        expect(@gsl_wrapper.data).to eq(GSL::Complex.alloc(5,6))
      end
    end

    context "#mean" do
      it "computes mean" do
        expect(@gsl_wrapper.mean).to eq(3.5)
      end
    end

    context "#map!" do
      it "destructively maps" do
        expect(@gsl_wrapper.map! { |a| a += 1 }).to eq(
          Daru::Accessors::GSLWrapper.new([2,3,4,5,6,7], @stub_context)
        )
      end
    end

    context "#delete_at" do
      it "deletes at key" do
        expect(@gsl_wrapper.delete_at(2)).to eq(3)

        expect(@gsl_wrapper).to eq(
          Daru::Accessors::GSLWrapper.new([1,2,4,5,6], @stub_context)
        )
      end
    end

    context "#index" do
      it "returns index of value" do
        expect(@gsl_wrapper.index(3)).to eq(2)
      end
    end

    context "#push" do
      it "appends element" do
        expect(@gsl_wrapper.push(15)).to eq(
          Daru::Accessors::GSLWrapper.new([1,2,3,4,5,6,15], @stub_context)
        )
      end
    end
  end
end

