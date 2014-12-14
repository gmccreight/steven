require "steven/version"

module Steven

  class FileBucketer

    def initialize(spec_files)
      @spec_files = spec_files
      @spec_file_buckets = []
    end

    def bucket_them(num_buckets)
      @spec_file_buckets = []
      if num_buckets < 2
        @spec_file_buckets = [FileBucket.new(0, @spec_files)]
      else
        @spec_files = biggest_first(@spec_files)

        index = num_buckets - 1
        (0..num_buckets - 1).each do |index|
          @spec_file_buckets << FileBucket.new(index, [])
        end

        spec_files_copy = Array.new(@spec_files)

        while spec_files_copy.size > 0
          (0..num_buckets - 1).each do |bucket_index|
            if spec_files_copy.size > 0
              @spec_file_buckets[bucket_index].
                add_file(spec_files_copy.delete_at(0))
            end
          end
        end

      end
    end

    def biggest_first(spec_files)
      spec_files.sort{|a,b| b.size <=> a.size}
    end

    def get_bucket(index)
      @spec_file_buckets[index]
    end

  end

  class FileBucket < Struct.new(:index, :files)

    def add_file(file)
      files << file
    end

    def get_total_size
      total = 0
      files.each{|f| total += f.size}
      total
    end

  end

  class SpecFile < Struct.new(:name, :size)
  end

end
