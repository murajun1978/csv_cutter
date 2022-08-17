# frozen_string_literal: true

require 'csv_splitter'
require 'thor'

module CsvSplitter
  class CLI < Thor
    desc 'split_by_number_rows', 'split csv by number rows'
    method_options headers: :boolean, encoding: :string, col_sep: :string, quote_char: :string, number_rows: :numeric
    def split_by_number_rows(file_path, out_dir)
      symbolized_key_options = options.except('number_rows').keys.inject({}) do |new_options, key|
        new_options[key.to_sym] = options[key]
        new_options
      end

      splitter = CsvSplitter::Splitter.new(**symbolized_key_options.merge(out_dir: out_dir))
      splitter.split_by_number_rows(file_path: file_path, number_rows: options['number_rows'] || 10000)

      puts 'Successfully split csv.'
    end
  end
end
