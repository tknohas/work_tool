module ApplicationHelper
  def markdown_to_html(text)
    html = Commonmarker.to_html(text)
    raw(html)
  end
end
