citation_file_path = ENV["CITATION_FILE_PATH"].to_s

if !citation_file_path.empty? && File.exist?(citation_file_path)

  citation_cff_contents = File.read(citation_file_path)

  if citation_cff_contents.empty?
    system("echo 'CITATION.cff file is empty: #{citation_file_path}'")
  else
    citation_info_msg = <<~CITATIONINFO
      **Ensure proper citation** by uploading a plain text CITATION.cff file to the default branch of your repository.

      If using GitHub, a *Cite this repository* menu will appear in the About section, containing both APA and BibTeX formats. When exported to Zotero using a browser plugin, Zotero will automatically create an entry using the information contained in the .cff file.

      You can copy the contents for your CITATION.cff file here:

      <details><summary><strong>CITATION.cff</strong></summary>
      <p>

      ```
      #{citation_cff_contents}
      ```

      </p>
      </details>

      If the repository is not hosted on GitHub, a .cff file can still be uploaded to set your preferred citation. Users will be able to manually copy and paste the citation.

      Find more information on .cff files [here](https://github.com/citation-file-format/citation-file-format/blob/main/README.md) and [here](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files).
    CITATIONINFO

    File.open('citation_info_msg.txt', 'w') do |f|
      f.write citation_info_msg
    end

    system("gh issue comment #{ENV['ISSUE_ID']} --body-file citation_info_msg.txt")
  end
else
  system("echo 'No citation .cff file found at #{citation_file_path}'")
end
