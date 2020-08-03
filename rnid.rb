#!/usr/bin/env ruby

require 'yaml'


def yml2md(filename)
  rnids = YAML.load(File.read(filename))

  rnids.each_with_index do |rnid, idx|
    if idx != 0
      puts ""
      puts ""
    end

    puts "### #{rnid["dominio"]}"
    puts ""
    puts "- Especificação técnica: #{rnid["especificacao"]["acronimo_com_versao"]} / #{rnid["especificacao"]["designacao"]}"
    puts "- Classificação: #{rnid["classificacao"]}"
    if rnid["prazo_para_aplicacao"].is_a?(Array)
      puts "- Prazo para aplicação:"
      rnid["prazo_para_aplicacao"].each do |prazo|
        puts "  - #{prazo}"
      end
    else
      puts "- Prazo para aplicação: #{rnid["prazo_para_aplicacao"]}"
    end
    puts "- Referências:"

    rnid["referencias"].each do |referencia|
      puts "  - [#{referencia["nome"]}](#{referencia["fonte"]}), #{referencia["entidade"]}"
    end
  end
end

puts "## Formato de dados, incluindo código de carateres, formato de som e imagens (fixas e animadas), audiovisuais, dados gráficos e de pré -impressão"
yml2md("rnid/tabela1.yml")

puts "## Tecnologias de interface web, incluindo acessibilidade, ergonomia, compatibilidade e integração de serviços"
yml2md("rnid/tabela3.yml")
