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

    def folder_links(cur, active_item)
        lst = cur ? cur.children : Folder.roots

        ret = ""
        for f in lst
            active = active_item && f == active_item.folder
            ret << content_tag(:li, class: 'nav-item') do
                link_to(f.name, f, class: 'ps-3' + (active ? ' active' : '')) + content_tag(:ul, class: 'pl-2 list-unstyled') { folder_links(f, active_item) }
            end
        end
        ret.html_safe
    end
end
