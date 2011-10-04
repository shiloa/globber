$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'fnmatch'

describe FNMatch do

	describe 'Matching functions' do

		#****************************************
		# test all functions that return true/false
		# based on pattern matching
		#****************************************
		describe '#match' do
			it "should return true when the given pattern exists in the input string" do
				FNMatch.match('john', '*hn').should  == true
				FNMatch.match('john', '*h*n').should == true
				FNMatch.match('john like amy', '*like*').should == true

			end

			it "should return false when the given pattern doesn't exist in the input string" do
				FNMatch.match('john', 'hn').should   == false
				FNMatch.match('john', '*xy*').should == false
				FNMatch.match('john hates sam', 'xyz').should == false
			end
		end

		describe '#match_r' do
			it "should return true when the given pattern exists in the input string" do
				FNMatch.match_r('*hn', 'john').should  == true
				FNMatch.match_r('*h*n', 'john').should == true
				FNMatch.match_r('*like*', 'john likes amy').should == true
			end

			it "should return false when the given pattern doesn't exist in the input string" do
				FNMatch.match_r('hn', 'john').should   == false
				FNMatch.match_r('*xy*', 'john').should == false
				FNMatch.match_r('xyz', 'john hates sam').should == false
			end
		end

		describe '#match_any_pattern' do
			it "should return true when there's at least one matching pattern in the list" do
				FNMatch.match_any_pattern('john', ['*hn', 'boe', 'pi*p']).should  == true
				FNMatch.match_any_pattern('john', ['*hn', '*oh*', 'pi*p']).should == true
				FNMatch.match_any_pattern('john likes amy', ['xz', '*like*', 'pi*p']).should == true
			end

			it "should return false when there are no matching patterns in the list" do
				FNMatch.match_any_pattern('john', ['hn', 'boe',  'pi*p']).should == false
				FNMatch.match_any_pattern('john', ['hn', 'oh',  'pi*p']).should  == false
				FNMatch.match_any_pattern('john hates sam', ['hn', 'oh',  'pi*p']).should  == false
			end
		end

		describe '#match_any_string' do
			it "returns true when there's at least one string in the list that matches the pattern" do
				FNMatch.match_any_string('*hn', ['john', 'sam', 'jeeves']).should  == true
				FNMatch.match_any_string('*am*', ['john', 'sam', 'jeeves']).should == true
				FNMatch.match_any_string('*am*', ['john like amy', 'sam never met john', 'jeeves is a silly name']).should == true
			end

			it "returns false when there are not strings in the list that match the pattern" do
				FNMatch.match_any_string('*hn', ['amy', 'sue',  'sally']).should == false
				FNMatch.match_any_string('my', ['amy', 'sue',  'sally']).should  == false
				FNMatch.match_any_string('sally misses sue', ['amy', 'sue',  'sally']).should == false
			end
		end

	end # matching functions

	describe "Searching functions" do
		#****************************************
		# test all functions that extract value
		# based on pattern matching
		#****************************************

		# TODO: implement and test.
		describe "#find"
		describe "#find_all"

	end # searching functions
end