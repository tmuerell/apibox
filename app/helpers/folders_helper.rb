module FoldersHelper
    def breadcrumbs(folder)
        res = []
        cur = folder
        while cur
            res << content_tag(:li, class: 'breadcrumb-item') do 
                link_to( "<span class=\"bi bi-folder\"></span>&nbsp;#{cur.name}".html_safe, cur)
            end
            cur = cur.parent
        end
        res.reverse.join("").html_safe
    end
end
