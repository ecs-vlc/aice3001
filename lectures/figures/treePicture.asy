size(200,0);

import drawtree;

TreeNode rule1 = makeNode("Rule 1");
TreeNode rule2 = makeNode(rule1, "Rule 2");
TreeNode rule3 = makeNode(rule1, "Rule 3");
TreeNode rule4 = makeNode(rule2, "Rule 4");
TreeNode leaf1 = makeNode(rule2, "$\mathcal{L}_1$");
TreeNode leaf2 = makeNode(rule3, "$\mathcal{L}_2$");
TreeNode leaf3 = makeNode(rule3, "$\mathcal{L}_3$");
TreeNode leaf4 = makeNode(rule4, "$\mathcal{L}_4$");
TreeNode leaf5 = makeNode(rule4, "$\mathcal{L}_5$");

draw(rule1, (0,0));
