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

    def folder_links(cur)
        lst = cur ? cur.children : Folder.roots

        ret = ""
        for f in lst
            ret << content_tag(:li, class: 'nav-item') { link_to f.name, f, class: 'nav-link' }
        end
        ret.html_safe
    end
end
