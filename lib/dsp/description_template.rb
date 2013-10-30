# -*- coding: utf-8 -*-
module DSP
  class DescriptionTemplate < Spira::Base

    include Spira::Resource
    #has_many :statement_templates, :predicate => RDF::RDFS.subClassOf, :type => "DSP::StatementTemplate"
    property :label, :predicate => RDF::RDFS.label, :type => String
    property :statement_order, :predicate => RDF::REG.statementOrder, :type => String
    property :id_field, :predicate => RDF::REG.idField, :type => String
    property :resource_class, :predicate => RDF::DSP.resourceClass, :type => RDF::URI
    #define_type RDF::DSP.DescriptionTemplate

    def statement_templates
      sparql =<<-EOF
SELECT distinct ?statement_template_uri
WHERE {
  <#{self.subject.to_s}> <#{RDF::RDFS.subClassOf.to_s}> ?statement_template_uri.
}
EOF
      # rdfs:subClassOfの先が自分自身でないとき、statement_templatesに加える
      statement_templates = SPARQL.execute(sparql, Spira.repository(:default)).reject do |solution| 
        solution.statement_template_uri.to_s == self.subject.to_s 
      end.map do |solution|
        ::DSP::StatementTemplate.for(RDF::URI.new(solution.statement_template_uri))
      end
      return statement_templates
    end
  end
end
