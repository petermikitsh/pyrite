class Paper < ActiveRecord::Base

  belongs_to :project

  def toBib(format)
    case format
      when "IEEE"
        return toIEEE
      when "APA"
        return toAPA
      when "MLA"
        return toMLA
      when "CHICAGO"
        return toCHICAGO
    end
  end


  def toIEEE
    bib = "#{authors}, \"#{title},\" "

    unless journal.nil? || journal.empty?
      bib += "#{journal}, "
    end

    unless volume.nil? || volume.empty?
      bib += "vol. #{volume}, "
    end

    unless issue.nil? || issue.empty?
      bib += "no. #{issue}, "
    end

    unless pages.nil? || pages.empty?
      bib += "pp. #{pages}, "
    end

    unless published_on.nil?
      bib += "#{published_on.strftime('%b. %Y.')}"
    end

    bib.strip!

    if bib[-1] == ","
      bib = bib[0..-2]
    end

    bib
  end

  def toAPA
    bib = "#{authors}, "

    unless published_on.nil?
      bib += "(#{published_on.strftime('%Y')}). "
    end

    bib += "#{title}. "

    unless journal.nil? || journal.empty?
      bib += "#{journal}. "
    end

    unless volume.nil? || volume.empty?
      bib += "vol. #{volume}"
    end

    unless issue.nil? || issue.empty?
      bib += "(#{issue}), "
    end

    unless pages.nil? || pages.empty?
      bib += "#{pages}"
    end

    bib.strip!

    if bib[-1] == "," || "."
      bib = bib[0..-1]
    end

    bib
  end

  def toMLA
    bib = "#{authors}. \"#{title}.\" "

    unless journal.nil? || journal.empty?
      bib += "#{journal} "
    end

    unless volume.nil? || volume.empty?
      bib += "#{volume}."
    end

    unless issue.nil? || issue.empty?
      bib += "#{issue} "
    end

    unless published_on.nil?
      bib += "(#{published_on.strftime('%b. %Y.')}): "
    end

    unless pages.nil? || pages.empty?
      bib += "#{pages}"
    end

    bib.strip!

    if bib[-1] == "." || ":"
      bib = bib[0..-1]
    end

    bib
  end

  def toCHICAGO
    bib = "#{authors}. \"#{title}.\" "

    unless journal.nil? || journal.empty?
      bib += "#{journal} "
    end

    unless volume.nil? || volume.empty?
      bib += "#{volume} "
    end

    unless issue.nil? || issue.empty?
      bib += "(#{issue}) "
    end

    unless published_on.nil?
      bib += "(#{published_on.strftime('%b %Y')}) : "
    end

    unless pages.nil? || pages.empty?
      bib += "#{pages}"
    end

    bib.strip!

    if bib[-1] == "." || ":"
      bib = bib[0..-1]
    end

    bib
  end

end
