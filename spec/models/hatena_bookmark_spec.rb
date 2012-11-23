# coding: utf-8
require 'spec_helper'

describe HatenaBookmark do
  before do
    time_now = Time.local(2012, 11, 21, 12, 0, 0)
    Time.stub(:now).and_return time_now
    @hatena = HatenaBookmark.new
    hatebu_response = File.open File.join(fixture_path, 'b-hatena-entrylist.xml')
    stub_request(:get, Settings.hatena_rss_url).
       to_return(:status => 200, :body => hatebu_response, :headers => {})
  end

  describe "#get_today_gist" do
    it "今日はてブされたgistのURLとはてブ総数を返すこと" do
      @hatena.get_today_gist.should == []
    end
  end

  describe "#save_today_gist" do
    it "Gistsのレコードが増えること" do
      Proc.new { @hatena.save_today_gist }.should change(Gist, :count).by(10)
    end
  end
end
