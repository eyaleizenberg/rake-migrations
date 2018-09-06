require 'active_record'
require 'rake_migration'

describe RakeMigration do
  context "version_from_path" do
    it "should extract rake id from file name" do
      expect(RakeMigration.version_from_path('a/2/201810162054_xyz.rake3')).to eq('201810162054')
      expect(RakeMigration.version_from_path('2/201810162054_xyz.rake3')).to eq('201810162054')
    end
  end

  context "mark_complete" do
    it "should use find_or_create_by for rails 4" do
      expect(RakeMigration).to receive(:find_or_create_by).with(hash_including(:version)).and_return(true)
      RakeMigration.mark_complete('a/2/201810162054_xyz.rake3')
    end

    it "should use find_or_create_by_version for rails 3" do
      allow(RakeMigration).to receive(:respond_to?).and_call_original
      expect(RakeMigration).to receive(:respond_to?).with(:find_or_create_by).and_return(false)
      expect(RakeMigration).to receive(:find_or_create_by_version).and_return(true)
      RakeMigration.mark_complete('a/2/201810162054_xyz.rake3')
    end
  end
end
