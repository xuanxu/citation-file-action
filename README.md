# Open Journals :: Citation file

This action adds a comment with the contents of a CITATION.cff file.

## Usage

Usually this action is used as a final step in a workflow accepting a paper after depositing and DOI generation is complete.
To receive a comment in a GitHub issue with the code of a `CITATION.cff` file to copy, the input variables `gh_token`, `issue_id`, `reviews_repo`, and `citation_file_path` should be passed.

### Inputs

The action accepts the following inputs:

- **citation_file_path**: Required. The path to the citation file.
- **reviews_repo**: Required. The repository containing the review issue for the paper.
- **issue_id**: Required. The issue number of the submission (to post a link to the tweet or toot).
- **gh_token**: Required. The github token to use for replying to the review issue.

### Example

Used as a step in a workflow `.yml` file in a repo's `.github/workflows/` directory passing custom input values from diferent sources: event inputs, other step's outputs, secrets and directly:

````yaml
on:
  workflow_dispatch:
   inputs:
      issue_id:
        description: 'The issue number of the submission'
jobs:
  processing:
    runs-on: ubuntu-latest
    env:
      GH_ACCESS_TOKEN: ${{ secrets.BOT_TOKEN }}
    steps:
      - compile paper ...
      - generate files...
      - deposit paper...
      - name: Citaion
        uses: xuanxu/citation-file-action@main
        with:
          citation_file_path: ${{ steps.generate-files.outputs.citation_file_path}}
          reviews_repo: openjournals/joss-reviews
          issue_id: ${{ github.event.inputs.issue_id }}
          gh_token: ${{ secrets.GITHUB_TOKEN }}
```
