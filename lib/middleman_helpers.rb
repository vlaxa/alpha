module MiddlemanHelpers

  GITHUB_URL = 'https://github.com'

  # Returns URI of the current page's source file in the GitHub repository for
  # online edit.
  def github_edit_link
    source_file_path = current_page.file_descriptor.relative_path
    repo_slug = config[:site][:github][:repo_slug]
    branch = config[:site][:github][:branch]

    [GITHUB_URL, repo_slug, 'edit', branch, config[:source], source_file_path].join('/')
  end

  # Returns SVG code to use beforehand declared SVG symbol.
  def use_icon(icon_id)
    <<-HTML
      <svg xmlns="http://www.w3.org/2000/svg" class="icon">
        <use xlink:href="#icon-#{icon_id}" />
      </svg>
    HTML
  end
end
