require "steven"
require "minitest/autorun"

describe Steven do

  before :each do
    @all_files = []
    @all_files << Steven::SpecFile.new("models/admin_spec.rb", 200)
    @all_files << Steven::SpecFile.new("models/membeship_spec.rb", 800)
    @all_files << Steven::SpecFile.new("models/user_spec.rb", 1200)
    @all_files << Steven::SpecFile.new("request/admin_spec.rb", 300)
    @all_files << Steven::SpecFile.new("request/membeship_spec.rb", 700)
    @all_files << Steven::SpecFile.new("request/wedding_spec.rb", 900)
    @all_files << Steven::SpecFile.new("utils/date_utils.rb", 100)
    @all_files << Steven::SpecFile.new("utils/form_utils.rb", 1000)
    @all_files << Steven::SpecFile.new("utils/email_utils.rb", 1200)
    @bucketer = Steven::FileBucketer.new(@all_files)
  end

  it "should assign them all into one if only one bucket is asked for" do
    @bucketer.bucket_them(1)
    assert_equal @bucketer.get_bucket(0).files.size, @all_files.size
  end

  describe "splitting into 2" do

    before :each do
      @bucketer.bucket_them(2)
    end

    it "should split them into 2 with even distribution of size" do
      bucket_0_size = @bucketer.get_bucket(0).get_total_size
      bucket_1_size = @bucketer.get_bucket(1).get_total_size
      assert_in_delta bucket_0_size, bucket_1_size, 500
    end

    it "should have all the files" do
      assert_equal @bucketer.get_bucket(0).files.size +
        @bucketer.get_bucket(1).files.size, @all_files.size
    end

    it "should have different files" do
      assert @bucketer.get_bucket(0).files[0] !=
        @bucketer.get_bucket(1).files[0]
    end

    it "should not split the 9 files evenly" do
      assert @bucketer.get_bucket(0).files.size !=
        @bucketer.get_bucket(1).files.size
    end

  end

  describe "splitting into 3" do

    before :each do
      @bucketer.bucket_them(3)
    end

    it "should split them into 2 with even distribution of size" do
      bucket_0_size = @bucketer.get_bucket(0).get_total_size
      bucket_1_size = @bucketer.get_bucket(1).get_total_size
      bucket_2_size = @bucketer.get_bucket(2).get_total_size
      assert_in_delta bucket_0_size, bucket_1_size, 500
      assert_in_delta bucket_1_size, bucket_2_size, 500
    end

    it "should have all the files" do
      assert_equal @bucketer.get_bucket(0).files.size +
        @bucketer.get_bucket(1).files.size +
        @bucketer.get_bucket(2).files.size, 
        @all_files.size
    end

    it "should have different files" do
      assert @bucketer.get_bucket(0).files[0] !=
        @bucketer.get_bucket(1).files[0]
    end

    it "should split the 9 files evenly into 3" do
      assert @bucketer.get_bucket(0).files.size == @all_files.size / 3
      assert @bucketer.get_bucket(1).files.size == @all_files.size / 3
      assert @bucketer.get_bucket(2).files.size == @all_files.size / 3
    end

  end

end
