$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'globber'

describe Globber do

	describe 'Matching functions' do

		#****************************************
		# test all functions that return true/false
		# based on pattern matching
		#****************************************
		describe '#match' do
			it "should return true when the given pattern exists in the input string" do
				Globber.match('john', '*hn').should be_true
				Globber.match('john', '*h*n').should be_true
				Globber.match('john like amy', '*like*').should be_true
			end

			it "should return false when the given pattern doesn't exist in the input string" do
				Globber.match('john', 'hn').should   be_false
				Globber.match('john', '*xy*').should be_false
				Globber.match('john hates sam', 'xyz').should be_false
			end

      it "should properly account for module flags" do
        Globber.match('john', '*HN', Globber::FNM_IGNORE_CASE).should  be_true
      end

      it "should raise TypeError when improper parameters are provided" do
        lambda { Globber.match('john', 1) }.should raise_error(TypeError)
        lambda { Globber.match(Object.new, -10) }.should raise_error(TypeError)
      end
		end

		describe '#match_any_pattern' do
			it "should return true when there's at least one matching pattern in the list" do
				Globber.match_any_pattern('john', ['*hn', 'boe', 'pi*p']).should  be_true
				Globber.match_any_pattern('john', ['*hn', '*oh*', 'pi*p']).should be_true
				Globber.match_any_pattern('john likes amy', ['xz', '*like*', 'pi*p']).should be_true
			end

			it "should return false when there are no matching patterns in the list" do
				Globber.match_any_pattern('john', ['hn', 'boe',  'pi*p']).should be_false
				Globber.match_any_pattern('john', ['hn', 'oh',  'pi*p']).should  be_false
				Globber.match_any_pattern('john hates sam', ['hn', 'oh',  'pi*p']).should  be_false
			end

      it "should raise TypeError when improper parameters are provided" do
        lambda { Globber.match_any_pattern(/blah/i, 1) }.should raise_error(TypeError)
        lambda { Globber.match_any_pattern(Object.new, {}) }.should raise_error(TypeError)
      end
		end

		describe '#match_any_string' do
			it "returns true when there's at least one string in the list that matches the pattern" do
				Globber.match_any_string('*hn', ['john', 'sam', 'jeeves']).should  be_true
				Globber.match_any_string('*am*', ['john', 'sam', 'jeeves']).should be_true
				Globber.match_any_string('*am*', ['john like amy', 'sam never met john', 'jeeves is a silly name']).should be_true
			end

			it "returns false when there are not strings in the list that match the pattern" do
				Globber.match_any_string('*hn', ['amy', 'sue',  'sally']).should be_false
				Globber.match_any_string('my', ['amy', 'sue',  'sally']).should  be_false
				Globber.match_any_string('sally misses sue', ['amy', 'sue',  'sally']).should be_false
			end

      it "should raise TypeError when improper parameters are provided" do
        lambda { Globber.match_any_string(/blah/i, 1) }.should raise_error(TypeError)
        lambda { Globber.match_any_string(Object.new, {}) }.should raise_error(TypeError)
      end
		end

	end # matching functions

	describe "Searching functions" do
		#****************************************
		# test all functions that extract value
		# based on pattern matching
		#****************************************

		describe "#find_pattern" do
			it "returns the pattern that matches the string, or nil if no matches were found" do
				Globber.find_pattern('john', ['*hn', 'boe', 'pi*p', 'jo*']).should eq( '*hn' )
				Globber.find_pattern('john likes amy', ['xz', '*likes*', 'pi*p']).should eq( '*likes*' )
			end
		end
		describe "#find_all"

	end # searching functions
end
