/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.93
 * Generated at: 2024-10-15 13:15:02 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.vistas;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import pe.edu.vallegrande.dao.ProductsDAO;
import pe.edu.vallegrande.dto.products;
import java.util.List;

public final class Listar_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1727444324732L));
    _jspx_dependants.put("jar:file:/C:/Users/willi/.m2/repository/javax/servlet/jstl/1.2/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153403082000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(4);
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("pe.edu.vallegrande.dto.products");
    _jspx_imports_classes.add("pe.edu.vallegrande.service.ProductsDAO");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html lang=\"es\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <title>Gestión de Productos</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\">\r\n");
      out.write("    <link href=\"https://unpkg.com/ionicons@4.5.10-0/dist/css/ionicons.min.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"https://unpkg.com/ionicons@4.5.10-0/dist/css/ionicons.min.css\" rel=\"stylesheet\">\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div class=\"container mt-5\">\r\n");
      out.write("\r\n");
      out.write("    <h1>Productos</h1>\r\n");
      out.write("    <a href=\"#\" data-toggle=\"modal\" data-target=\"#addProductModal\"\r\n");
      out.write("       data-accion=\"add\" class=\"btn btn-primary mb-3\" >Agregar\r\n");
      out.write("    </a>\r\n");
      out.write("\r\n");
      out.write("    <table class=\"table table-bordered\">\r\n");
      out.write("        <thead class=\"thead-light\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <th>ID</th>\r\n");
      out.write("            <th>Nombre</th>\r\n");
      out.write("            <th>Descripción</th>\r\n");
      out.write("            <th>Categoría</th>\r\n");
      out.write("            <th>Precio Compra</th>\r\n");
      out.write("            <th>Precio Venta</th>\r\n");
      out.write("            <th>Unidad</th>\r\n");
      out.write("            <th>Cantidad</th> <!-- Nueva columna para cantidad -->\r\n");
      out.write("            <th>ID Proveedor</th> <!-- Cambiado a ID Proveedor -->\r\n");
      out.write("            <th>Estado</th>\r\n");
      out.write("            <th>Acciones</th>\r\n");
      out.write("\r\n");
      out.write("        </tr>\r\n");
      out.write("        </thead>\r\n");
      out.write("        <tbody>\r\n");
      out.write("        ");

            ProductsDAO dao = new ProductsDAO();
            List<products> list = dao.listar();
            for (products product : list) {
        
      out.write("\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td>");
      out.print( product.getProducts_id() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getName() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getDescription() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getCategory() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getPurchase_price() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getSales_price() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getUnit() );
      out.write("</td>\r\n");
      out.write("            <td>");
      out.print( product.getQuantity() );
      out.write("</td> <!-- Mostrar cantidad -->\r\n");
      out.write("            <td>");
      out.print( product.getSuppliers_id() );
      out.write("</td> <!-- Mostrar el ID del proveedor -->\r\n");
      out.write("            <td>");
      out.print( product.getStatus() );
      out.write("</td>\r\n");
      out.write("            <td>\r\n");
      out.write("                <a href=\"#\" data-toggle=\"modal\" data-target=\"#addProductModal\"\r\n");
      out.write("                   data-accion=\"add\" data-id=\"");
      out.print( product.getProducts_id() );
      out.write("\">\r\n");
      out.write("                    <i class=\"icon ion-md-add\"></i>\r\n");
      out.write("                </a>\r\n");
      out.write("                <a href=\"controlador?accion=editar&id=");
      out.print( product.getProducts_id() );
      out.write("\">\r\n");
      out.write("                    <i class=\"icon ion-md-create\"></i>\r\n");
      out.write("                </a>\r\n");
      out.write("                <!--<a href=\"controlador?accion=add&id=");
      out.print( product.getProducts_id() );
      out.write("\"><i class=\"icon ion-md-add\"></i></a>-->\r\n");
      out.write("                <!--<a href=\"controlador?accion=editar&id=");
      out.print( product.getProducts_id() );
      out.write("\" ><i class=\"icon ion-md-create\"></i></a>-->\r\n");
      out.write("                <a href=\"controlador?accion=eliminar&id=");
      out.print( product.getProducts_id() );
      out.write("\" ><i class=\"icon ion-md-trash\"></i></a>\r\n");
      out.write("                <a href=\"controlador?accion=Restore&id=");
      out.print( product.getProducts_id() );
      out.write("\" ><i class=\"icon ion-md-refresh\"></i></a>\r\n");
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        ");

            }
        
      out.write("\r\n");
      out.write("        </tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <!-- Modal -->\r\n");
      out.write("    <div class=\"modal fade\" id=\"addProductModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"addProductModalLabel\" aria-hidden=\"true\">\r\n");
      out.write("        <div class=\"modal-dialog\" role=\"document\">\r\n");
      out.write("            <div class=\"modal-content\">\r\n");
      out.write("                <div class=\"modal-header\">\r\n");
      out.write("                    <h5 class=\"modal-title\" id=\"addProductModalLabel\">Agregar Producto</h5>\r\n");
      out.write("                    <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\r\n");
      out.write("                        <span aria-hidden=\"true\">&times;</span>\r\n");
      out.write("                    </button>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"modal-body\">\r\n");
      out.write("                    <form action=\"controlador\" method=\"post\">\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Nombre:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtName\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Descripción:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtDescription\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Categoría:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtCategory\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Precio Compra:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtPpurchase\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Precio Venta:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtPsale\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Unidad:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtUnit\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"form-group\">\r\n");
      out.write("                            <label>Estado:</label>\r\n");
      out.write("                            <input type=\"text\" name=\"txtStatus\" class=\"form-control\" required>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <button type=\"submit\" name=\"accion\" value=\"agregar\" class=\"btn btn-success\">Agregar</button>\r\n");
      out.write("                    </form>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    ");
      //  c:if
      org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
      boolean _jspx_th_c_005fif_005f0_reused = false;
      try {
        _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
        _jspx_th_c_005fif_005f0.setParent(null);
        // /vistas/Listar.jsp(125,4) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty param.accion and param.accion == 'editar'}", boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null)).booleanValue());
        int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
        if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("        ");

            int id = Integer.parseInt(request.getParameter("id"));
            products productToEdit = dao.list(id);
        
            out.write("\r\n");
            out.write("        <div class=\"modal fade show\" id=\"editProductModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"editProductModalLabel\" aria-hidden=\"true\" style=\"display: block;\">\r\n");
            out.write("            <div class=\"modal-dialog\" role=\"document\">\r\n");
            out.write("                <div class=\"modal-content\">\r\n");
            out.write("                    <div class=\"modal-header\">\r\n");
            out.write("                        <h5 class=\"modal-title\" id=\"editProductModalLabel\">Editar Producto</h5>\r\n");
            out.write("                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\" onclick=\"window.location.href='controlador?accion=listar'\">\r\n");
            out.write("                            <span aria-hidden=\"true\">&times;</span>\r\n");
            out.write("                        </button>\r\n");
            out.write("                    </div>\r\n");
            out.write("                    <div class=\"modal-body\">\r\n");
            out.write("                        <form action=\"controlador\" method=\"post\">\r\n");
            out.write("                            <input type=\"hidden\" name=\"txtId\" value=\"");
            out.print( productToEdit.getProducts_id() );
            out.write("\" readonly>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Nombre:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtName\" class=\"form-control\" value=\"");
            out.print( productToEdit.getName() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Descripción:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtDescription\" class=\"form-control\" value=\"");
            out.print( productToEdit.getDescription() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Categoría:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtCategory\" class=\"form-control\" value=\"");
            out.print( productToEdit.getCategory() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Precio Compra:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtPpurchase\" class=\"form-control\" value=\"");
            out.print( productToEdit.getPurchase_price() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Precio Venta:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtPsale\" class=\"form-control\" value=\"");
            out.print( productToEdit.getSales_price() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Unidad:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtUnit\" class=\"form-control\" value=\"");
            out.print( productToEdit.getUnit() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>ID Proveedor:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtProveedor\" class=\"form-control\" value=\"");
            out.print( productToEdit.getSuppliers_id() );
            out.write("\" readonly>\r\n");
            out.write("                            </div>\r\n");
            out.write("                            <div class=\"form-group\">\r\n");
            out.write("                                <label>Estado:</label>\r\n");
            out.write("                                <input type=\"text\" name=\"txtStatus\" class=\"form-control\" value=\"");
            out.print( productToEdit.getStatus() );
            out.write("\" required>\r\n");
            out.write("                            </div>\r\n");
            out.write("\r\n");
            out.write("                            <button type=\"submit\" name=\"accion\" value=\"Actualizar\" class=\"btn btn-primary\">Actualizar</button>\r\n");
            out.write("                            <a href=\"controlador?accion=listar\" class=\"btn btn-secondary\">Regresar</a>\r\n");
            out.write("                        </form>\r\n");
            out.write("                    </div>\r\n");
            out.write("                </div>\r\n");
            out.write("            </div>\r\n");
            out.write("        </div>\r\n");
            out.write("    ");
            int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
        _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
        _jspx_th_c_005fif_005f0_reused = true;
      } finally {
        org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f0_reused);
      }
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("<script src=\"https://code.jquery.com/jquery-3.5.1.slim.min.js\"></script>\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js\"></script>\r\n");
      out.write("<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}