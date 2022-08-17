# frozen_string_literal: true

require "test_helper"

class TestCsvCutter < Minitest::Test
  def setup
    @csv =
      CsvCutter::Csv.new(
        headers: true,
        out_dir: temp_dir,
      )
  end

  def setup_csv_without_headers
    @csv =
      CsvCutter::Csv.new(
        headers: false,
        out_dir: temp_dir,
      )
  end

  def teardown
    delete_csv_file
    delete_temp_dir
  end

  def test_it_generates_split_csv_and_return_true
    generate_csv_file(csv_data)

    assert_equal true, @csv.split_by_number_rows(file_path: @tmp_csv.path, number_rows: 3)
    assert_equal Dir.children(temp_dir).sort, ["test_1.csv", "test_2.csv", "test_3.csv", "test_4.csv"]

    assert_equal [["name", "email"], ["user1", "user1@example.com"], ["user2", "user2@example.com"], ["user3", "user3@example.com"]], CSV.read("#{temp_dir}/test_1.csv")
    assert_equal [["name", "email"], ["user4", "user4@example.com"], ["user5", "user5@example.com"], ["user6", "user6@example.com"]], CSV.read("#{temp_dir}/test_2.csv")
    assert_equal [["name", "email"], ["user7", "user7@example.com"], ["user8", "user8@example.com"], ["user9", "user9@example.com"]], CSV.read("#{temp_dir}/test_3.csv")
    assert_equal [["name", "email"], ["user10", "user10@example.com"]], CSV.read("#{temp_dir}/test_4.csv")
  end

  def test_it_generates_split_csv_without_headers
    setup_csv_without_headers
    generate_csv_file(csv_data(headers: false))

    assert_equal true, @csv.split_by_number_rows(file_path: @tmp_csv.path, number_rows: 3)
    assert_equal Dir.children(temp_dir).sort, ["test_1.csv", "test_2.csv", "test_3.csv", "test_4.csv"]

    assert_equal [["user1", "user1@example.com"], ["user2", "user2@example.com"], ["user3", "user3@example.com"]], CSV.read("#{temp_dir}/test_1.csv")
    assert_equal [["user4", "user4@example.com"], ["user5", "user5@example.com"], ["user6", "user6@example.com"]], CSV.read("#{temp_dir}/test_2.csv")
    assert_equal [["user7", "user7@example.com"], ["user8", "user8@example.com"], ["user9", "user9@example.com"]], CSV.read("#{temp_dir}/test_3.csv")
    assert_equal [["user10", "user10@example.com"]], CSV.read("#{temp_dir}/test_4.csv")
  end

  private

  def temp_dir
    @temp_dir ||= Dir.mktmpdir
  end

  def delete_temp_dir
    FileUtils.remove_entry_secure temp_dir
  end

  def generate_csv_file(csv)
    @tmp_csv = Tempfile.new('test.csv')
    @tmp_csv.write(csv)
    @tmp_csv.rewind
  end

  def delete_csv_file
    @tmp_csv&.close!
    @tmp_csv&.unlink
  end

  def csv_data(headers: true)
    CSV.generate do |csv|
      csv << %w[name email] if headers

      (1..10).each do |i|
        name = "user#{i}"
        email = "#{name}@example.com"
        csv << [name, email]
      end
    end
  end
end
