require 'dsp'

dsp_uri = "http://example.com/sample_schema_C"
metabridge_base_uri = "http://www.metabridge.jp/infolib/metabridge/api/description?graph="
fname = metabridge_base_uri + dsp_uri

Spira.add_repository(:default, RDF::Repository.load(fname))
dst = DSP::DescriptionSetTemplate.for(RDF::URI.new(@dsp_uri))
dst.description_templates.each do |dt|
  puts "-----------"
  dt.statement_templates.each do |st|
    p st
  end
end
