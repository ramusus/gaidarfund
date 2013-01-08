xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Фонд Егора Гайдара"
    xml.description "Фонд Егора Гайдара"
    xml.link root_url

    if @article_main
      xml.item do
        xml.title strip_tags(@article_main.title)
        xml.description strip_tags(@article_main.subtitle)
        xml.pubDate @article_main.published_at.to_s(:rfc822)
        xml.link article_url(@article_main)
        xml.guid article_url(@article_main)
      end
    end

    for article in @articles
      xml.item do
        xml.title strip_tags(article.title)
        xml.description strip_tags(article.subtitle)
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end

  end
end