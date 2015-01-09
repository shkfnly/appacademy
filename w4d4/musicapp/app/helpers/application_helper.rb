module ApplicationHelper

  def ugly_lyrics(lyrics)
    lyrics = lyrics.split("\r\n")
    lyrics.map do |line|
      "<p style='margin: 0;'>&#9835;#{h(line)}</p>"
    end.join("\n")
  end
end
