# frozen_string_literal: true

require 'csv'

module CsvSplitter
  class Splitter
    attr_reader :options, :out_dir, :file_mode

    def initialize(headers: false, out_dir:, encoding: nil, col_sep: ',', quote_char: '"')
      @options = {
        headers: headers,
        encoding: encoding,
        col_sep: col_sep,
        quote_char: quote_char,
      }
      @out_dir = out_dir
      @file_mode = encoding ? "w:#{encoding}" : 'w'
    end

    def split_by_number_rows(file_path:, number_rows: 10000)
      threads = []
      file_name = File.basename(file_path, ".*")

      CSV.foreach(file_path, **options).each_slice(number_rows).with_index(1) do |rows, idx|
        threads << Thread.new(idx) do |idx|
          CSV.open("#{out_dir}/#{file_name}_#{idx}.csv", file_mode, **options.slice(:col_sep, :quote_char)) do |csv_file|
            rows.each_with_index do |row, idx|
              case row
              when CSV::Row
                csv_file << row.headers if idx == 0 && row.is_a?(CSV::Row)
                csv_file << row.fields
              else
                csv_file << row
              end
            end
          end
        end
      end
      threads.each(&:join)
      true
    end
  end
end
