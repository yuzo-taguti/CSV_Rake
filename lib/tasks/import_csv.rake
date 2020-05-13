require 'csv'

namespace :import_csv do
desc "CSVデータをインポートするタスク"
task users: :environment do
    path = File.join Rails.root, "db/csv_data/csv_data.csv"
    list = []
    CSV.foreach(path, headers: true) do |row|
        list << {
            name: row["name"],
            age: row["age"],
            address: row["address"]
        }
      end

        puts "インポート処理を開始".red

      begin
        User.transaction do
        User.create!(list)
        end

        puts "インポート完了!!".green

      rescue ActiveModel::UnknownAttributeError => invalid
        puts "インポートに失敗：UnknownAttributeError".red

      end
    end
end
